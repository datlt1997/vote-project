document.addEventListener('DOMContentLoaded', function () {
  const fileInput = document.getElementById('csv-file-input');
  const triggerButton = document.getElementById('trigger-file-upload');
  const form = document.getElementById('import-form');

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
});

document.addEventListener('DOMContentLoaded', function () {
  const fileInput = document.getElementById('avatar-file');
  const uploadBtn = document.getElementById('upload-avatar-btn');
  const fileNameLabel = document.getElementById('avatar-filename');

  uploadBtn.addEventListener('click', function () {
    fileInput.click(); // Kích hoạt input file ẩn
  });

  fileInput.addEventListener('change', function () {
    if (fileInput.files.length > 0) {
      fileNameLabel.textContent = "Đã chọn: " + fileInput.files[0].name;
    } else {
      fileNameLabel.textContent = "";
    }
  });
});