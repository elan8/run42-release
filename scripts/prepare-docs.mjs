import { mkdirSync, readFileSync, readdirSync, writeFileSync, rmSync } from 'node:fs';
import { resolve, relative, sep } from 'node:path';
import { fileURLToPath } from 'node:url';

export const root = fileURLToPath(new URL('..', import.meta.url));
export const channel = 'Unreleased beta';
export function generate() {
  const pages = readdirSync(resolve(root, 'docs')).filter(name => name.endsWith('.md'));
  const output = resolve(root, 'site/.generated');
  if (relative(root, output).split(sep).join('/') !== 'site/.generated') throw new Error('Unsafe generated path');
  rmSync(output, { recursive: true, force: true });
  mkdirSync(output, { recursive: true });
  for (const page of pages) {
    let content = readFileSync(resolve(root, 'docs', page), 'utf8');
    content = content.replace(/\]\(\.\.\/examples/g, '](https://github.com/elan8/run42-release/tree/main/examples');
    content = content.replace(/\]\(([^)\s]+)\.md(#[^)]*)?\)/g, (match, link, fragment = '') => /^(https?:|mailto:)/.test(link) ? match : `](${link}${fragment})`);
    writeFileSync(resolve(output, page), content);
  }
  return { pages };
}
if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) generate();
