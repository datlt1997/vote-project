document.addEventListener('DOMContentLoaded', () => {
  const addButton = document.getElementById('add-option-btn');
  const optionsContainer = document.getElementById('options');

  addButton.addEventListener('click', () => {
    const time = new Date().getTime();
    const regexp = /new_options/g;

    const template = `
        <div class="nested-fields mb-2">
          <div class="input-group">
            <input type="text" name="poll[options_attributes][new_options][content]" class="form-control" placeholder="Option content">
            <div class="input-group-append">
              <button class="btn position-absolute end-0 remove_fields" type="button"><i class="fa fa-trash"></i></button>
            </div>
          </div>
        </div>
      `.replace(regexp, time);

    optionsContainer.insertAdjacentHTML('beforeend', template);
  });

  document.addEventListener('click', (e) => {
    if (e.target?.classList.contains("remove_fields")) {
      e.preventDefault();

      const fieldWrapper = e.target.closest(".nested-fields");
      
      // Tìm hidden field _destroy
      const destroyField = fieldWrapper.querySelector('input[name*="_destroy"]');
      
      if (destroyField) {
        destroyField.value = "1";
      }

      if (window.location.pathname.includes('edit')) {
        fieldWrapper.style.display = "none";
      } else {
        fieldWrapper.remove();
      }
    }
  });
});
