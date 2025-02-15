
let currentIndex = 0;

function showNextSlide() {
    const slides = document.querySelector('.slides');
    const totalSlides = slides.children.length;
    currentIndex = (currentIndex + 1) % totalSlides;
    const translateXValue = -currentIndex * 100;
    slides.style.transform = `translateX(${translateXValue}%)`;
}

setInterval(showNextSlide, 3000); // Change slide every 10 seconds
