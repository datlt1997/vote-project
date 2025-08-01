// app/javascript/controllers/option_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container"];

  connect() {
     console.log("OptionController connected");
  }

  add(event) {
    event.preventDefault();

    const time = new Date().getTime();
    const regexp = /new_options/g;

    const template = `
      <div class="nested-fields mb-2" data-option-target="field">
        <div class="input-group">
          <input type="text" name="poll[options_attributes][new_options][content]" class="form-control" placeholder="Thêm lựa chọn">
          <input type="hidden" name="poll[options_attributes][new_options][_destroy]" value="false">
          <div class="input-group-append">
            <button class="btn position-absolute end-0 remove_fields" data-action="click->option#remove" type="button">
              <i class="fa fa-trash"></i>
            </button>
          </div>
        </div>
      </div>
    `.replace(regexp, time);

    this.containerTarget.insertAdjacentHTML("beforeend", template);
  }

  remove(event) {
    event.preventDefault();

    const fieldWrapper = event.target.closest(".nested-fields");
    const destroyField = fieldWrapper.querySelector('input[name*="_destroy"]');

    if (destroyField) {
      destroyField.value = "1";
    }

    if (window.location.pathname.includes("edit")) {
      fieldWrapper.style.display = "none";
    } else {
      fieldWrapper.remove();
    }
  }
}
