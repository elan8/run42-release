import { defineConfig } from 'vitepress';
import { channel } from '../../scripts/prepare-docs.mjs';

const pages = { index: 'Overview', 'supported-scope': 'Supported scope', installation: 'Installation', 'getting-started': 'Your first simulation', examples: 'Examples', authentication: 'Accounts and API tokens', cli: 'Command reference', results: 'Results and verification', troubleshooting: 'Troubleshooting' };
export default defineConfig({
  title: 'Run42',
  description: 'SysML v2 simulation and verification: beta scope, installation, examples and command reference.',
  base: process.env.DOCS_BASE || '/run42-release/',
  srcDir: '.generated', cleanUrls: true,
  markdown: { languageAlias: { sysml: 'text', modelica: 'text' } },
  themeConfig: {
    siteTitle: 'Run42 docs',
    nav: [{ text: channel, link: '/' }, { text: 'Downloads', link: 'https://github.com/elan8/run42-release/releases' }, { text: 'Elan8', link: 'https://www.elan8.com' }],
    sidebar: [{ text: channel, items: Object.entries(pages).map(([page, text]) => ({ text, link: page === 'index' ? '/' : `/${page}` })) }],
    search: { provider: 'local' }, outline: [2, 3],
    socialLinks: [{ icon: 'github', link: 'https://github.com/elan8/run42-release' }],
    footer: { message: 'Models and results stay local. License retrieval and refresh require online access.', copyright: 'Elan8' }
  }
});
