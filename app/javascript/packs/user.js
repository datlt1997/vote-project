document.addEventListener('turbo:load', function () {
  // 📁 Import CSV file
  const fileInput = document.getElementById('csv-file-input');
  const triggerButton = document.getElementById('trigger-file-upload');
  const form = document.getElementById('import-form');

  if (fileInput && triggerButton && form) {
    triggerButton.addEventListener('click', function () {
      fileInput.click();
    });

    fileInput.addEventListener('change', function () {
      if (fileInput.files.length > 0) {
        triggerButton.classList.remove('btn-secondary');
        triggerButton.classList.add('btn-success');
        triggerButton.textContent = "File: " + fileInput.files[0].name;
        form.submit();
      }
    });
  }

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
