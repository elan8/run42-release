import { test } from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync, existsSync } from 'node:fs';
import { resolve, dirname } from 'node:path';
import { generate, root } from '../scripts/prepare-docs.mjs';

const { pages } = generate();
test('repository-relative guide links resolve before generation', () => {
  for (const page of pages) {
    const source = resolve(root, 'docs', page);
    for (const [, target] of readFileSync(source, 'utf8').matchAll(/\]\(([^)\s]+)\)/g)) {
      if (/^(?:https?:|#|\/)/.test(target)) continue;
      assert.ok(existsSync(resolve(dirname(source), target.split('#')[0])), `${page}: ${target}`);
    }
  }
});

test('preview guides do not advertise a nonexistent released version or private implementation', () => {
  assert.match(readFileSync(resolve(root, 'docs/index.md'), 'utf8'), /Unreleased beta/);
  assert.match(readFileSync(resolve(root, 'docs/installation.md'), 'utf8'), /No beta package is published yet/);
  for (const page of pages) {
    const content = readFileSync(resolve(root, 'site/.generated', page), 'utf8');
    assert.doesNotMatch(content, /github\.com\/elan8\/run42\/(?:blob|tree|issues)|run42\.simulate|CAPABILITIES\.md|ELAN8_BACKEND_READ_TOKEN/);
    assert.doesNotMatch(content, /releases\/(?:download|tag)\/v0\.0\.0/);
  }
});
