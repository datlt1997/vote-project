document.addEventListener('turbo:load', function () {
  // 📁 Import CSV file
  const fileInput = document.getElementById('csv-file-input');
  const importBtn = document.getElementById("import-btn");

  importBtn.addEventListener("click", function () {
    fileInput.click();
  });

  fileInput.addEventListener("change", function () {
    if (fileInput.files.length > 0) {
      document.getElementById("import-form").submit();
    }
  });
  

  // 📷 Upload Avatar file
  const fileAvatarInput = document.getElementById('avatar-file');
  const uploadBtn = document.getElementById('upload-avatar-btn');

  if (uploadBtn && fileAvatarInput) {
    uploadBtn.addEventListener('click', function () {
      fileAvatarInput.click();
      console.log("click!")
    });
  }
});
