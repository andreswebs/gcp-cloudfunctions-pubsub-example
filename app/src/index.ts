import type { PubsubMessage } from '@google-cloud/pubsub/build/src/publisher';
import type { Context } from '@google-cloud/functions-framework';

import { eventMaxAgeMs } from './constants';

async function main(event: PubsubMessage, context: Context) {
  console.log(JSON.stringify(event));
  console.log(JSON.stringify(context));

  const eventAgeMs = Date.now() - Date.parse(context.timestamp as string);

  if (event.data) {
    const data = Buffer.from(event.data as string, 'base64').toString();
    console.log(JSON.stringify({ data }));
    if (data === 'fail') {
      if (eventAgeMs > eventMaxAgeMs) {
        return;
      }
      throw new Error('FAIL');
    }
  }
}

export { main };
