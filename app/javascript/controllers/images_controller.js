import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["project"];

  connect() {
    this.currentIndex = 0;
    this.updateActiveImage();
  }

  next() {
    this.changeImage(1);
  }

  previous() {
    this.changeImage(-1);
  }

  changeImage(direction) {
    // 1. Remove active class from ALL images (important!)
    this.projectTargets.forEach(target => target.classList.remove("active"));

    // 2. Calculate the new index
    this.currentIndex = (this.currentIndex + direction + this.projectTargets.length) % this.projectTargets.length;

    // 3. Add active class to the CORRECT image
    this.updateActiveImage();
  }

  updateActiveImage() {
    this.projectTargets[this.currentIndex].classList.add("active");
  }
}