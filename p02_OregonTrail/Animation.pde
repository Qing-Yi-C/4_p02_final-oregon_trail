class Animation {
  PImage[] images;
  int imageCount;
  int frame;

  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + nf(i, 4) + ".jpg";
      images[i] = loadImage(filename);
      images[i].resize(220, 100);

          for (int p=0; p < images[i].pixels.length; p++) {
          if (images[i].pixels[p] == color(255)) {
            images[i].pixels[p] = color(#6FFBFF);
          }
      }
    }
  }

  void display(float xpos, float ypos) {
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
  }

  int getWidth() {
    return images[0].width;
  }

  int getHeight() {
   return images[0].height; 
  }
}
