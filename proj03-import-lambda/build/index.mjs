console.log('Loading function');

export const handler = async (event, context) => {
  console.log('value1 =', event.key1);
  console.log('value2 =', event.key2);
  console.log('value3 =', event.key3);
  return 'Anotjer welcome message from Terraform';
};
