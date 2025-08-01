import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display"]

  connect() {
    this.endTime = new Date(this.element.dataset.expiresAt)
    this.update()
    this.interval = setInterval(() => this.update(), 1000)
  }

  disconnect() {
    clearInterval(this.interval)
  }

  update() {
    const now = new Date()
    const diff = this.endTime - now

    if (diff <= 0) {
      this.displayTarget.textContent = "Đã hết hạn"
      clearInterval(this.interval)
      return
    }

    const hours = Math.floor(diff / (1000 * 60 * 60))
    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))
    const seconds = Math.floor((diff % (1000 * 60)) / 1000)

    this.displayTarget.textContent = `${hours}h ${minutes}m ${seconds}s`
  }
}
