class Rectangle {
  constructor(height, width) {
    this.height = height;
    this.width = width;
  }

  show() {
    rect(50, 50, this.width, this.height);
  }
}
