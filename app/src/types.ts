interface ActionMsg {
  action: string;
  notify: boolean;
}

function isActionMsg(obj: unknown): obj is ActionMsg {
  return (
    typeof obj === 'object' &&
    obj !== null &&
    'action' in obj &&
    'notify' in obj &&
    typeof obj.action === 'string' &&
    typeof obj.notify === 'boolean'
  );
}

export type { ActionMsg };
export { isActionMsg };
