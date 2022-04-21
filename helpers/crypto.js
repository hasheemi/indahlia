const crypt = (string) => {
  const text = `${string.length}pxm${string}`;
  const textToChars = (text) => text.split("").map((c) => c.charCodeAt(0));
  const byteHex = (n) => ("0" + Number(n).toString(35)).substr(-2);

  return text.split("").map(textToChars).map(byteHex).join("");
};

const decrypt = (string) => {
  return string
    .match(/.{1,2}/g)
    .map((hex) => parseInt(hex, 35))

    .map((charCode) => String.fromCharCode(charCode))
    .join("")
    .split("pxm")[1];
};

module.exports = { crypt, decrypt };
