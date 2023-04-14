import type { PubsubMessage } from '@google-cloud/pubsub/build/src/publisher';
import type { Context } from '@google-cloud/functions-framework';

import { eventMaxAgeMs } from './constants';

import { isActionMsg } from './types';

async function main(event: PubsubMessage, context: Context) {
  console.log(JSON.stringify(event));
  console.log(JSON.stringify(context));

  const eventAgeMs = Date.now() - Date.parse(context.timestamp as string);

  if (event.data) {
    const dataStr = Buffer.from(event.data as string, 'base64').toString();
    let data: Record<string, unknown>;

    try {
      data = JSON.parse(dataStr);

      if (!isActionMsg(data)) {
        throw new TypeError('mal-formed input');
      }

      console.log(JSON.stringify({ message: 'success', ...data }));

      if (data.action === 'fail') {
        if (eventAgeMs > eventMaxAgeMs) {
          return;
        }
        throw new Error('FAIL');
      }
    } catch (e) {
      const message = (e as Error).message;
      console.log(JSON.stringify({
        severity: 'ERROR',
        message,
      }));
    }

  }
}

export { main };
