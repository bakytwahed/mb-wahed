import fetch from 'node-fetch';

import createMountebankCallbackBody from './createMountebankCallbackBody';
import config from './config';

export default async ({
  operationType,
  pathKey,
  args,
  mountebankCallbackURL = config.mountebankCallbackURL,
}) => {
  const mountebankCallbackBody = createMountebankCallbackBody({
    operationType,
    pathKey,
    args,
  });
  const mountebankResult = await fetch(mountebankCallbackURL, {
    method: 'post',
    body: JSON.stringify(mountebankCallbackBody),
    headers: { 'Content-Type': 'application/json' },
  });
  const mountebankResponse = await mountebankResult.json();
  return mountebankResponse.response;
};
