const fs = require('fs');
const { execFileSync } = require('child_process');

const [file, label, keyFile] = process.argv.slice(2);
const manifest = JSON.parse(fs.readFileSync(file, 'utf8'));

manifest.name = `${manifest.name} ${label}`;
if (keyFile) {
  const publicKey = execFileSync('openssl', ['rsa', '-in', keyFile, '-pubout', '-outform', 'DER'], {
    stdio: ['ignore', 'pipe', 'ignore'],
  });
  manifest.key = publicKey.toString('base64');
}

fs.writeFileSync(file, JSON.stringify(manifest, null, 2) + '\n');
