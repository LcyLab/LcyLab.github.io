const fs = require('fs');
const path = require('path');

function copyDirectory(sourceDir, targetDir) {
  if (!fs.existsSync(sourceDir)) return;

  fs.mkdirSync(targetDir, { recursive: true });

  for (const entry of fs.readdirSync(sourceDir, { withFileTypes: true })) {
    const sourcePath = path.join(sourceDir, entry.name);
    const targetPath = path.join(targetDir, entry.name);

    if (entry.isDirectory()) {
      copyDirectory(sourcePath, targetPath);
    } else if (entry.isFile()) {
      fs.copyFileSync(sourcePath, targetPath);
    }
  }
}

hexo.extend.filter.register('after_generate', function copyArticlePictures() {
  const posts = hexo.locals.get('posts');
  if (!posts || !Array.isArray(posts.data)) return;

  for (const post of posts.data) {
    if (!post.source || !post.path) continue;

    const sourcePictureDir = path.join(
      hexo.source_dir,
      path.dirname(post.source),
      'picture'
    );
    const postRelativePath = String(post.path)
      .replace(/^[/\\]+/, '')
      .replace(/[/\\]index\.html$/, '');
    const targetPictureDir = path.join(
      hexo.public_dir,
      ...postRelativePath.split(/[\\/]+/),
      'picture'
    );

    copyDirectory(sourcePictureDir, targetPictureDir);
  }
});
