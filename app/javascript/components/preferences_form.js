export const initMultistepForm = () => {
  const multiStepFormEl = document.querySelector(".js-multistep-form");
  if (!multiStepFormEl){
    return;
  }
  const stepEls = multiStepFormEl.querySelectorAll(".js-multistep-form-step");
  const nextStepButtonEls = multiStepFormEl.querySelectorAll(
    ".js-multistep-form-step-next-btn"
  );
  const prevStepButtonEls = multiStepFormEl.querySelectorAll(
    ".js-multistep-form-step-previous-btn"
  );

  let stepNumber = 0;

  nextStepButtonEls.forEach(buttonEl => {
    buttonEl.addEventListener("click", () => {
      stepNumber += 1;
      updateUi();
    });
  });

  prevStepButtonEls.forEach(buttonEl => {
    buttonEl.addEventListener("click", () => {
      stepNumber -= 1;
      updateUi();
    });
  });

  const updateUi = () => {
    stepEls.forEach(stepEl => {
      stepEl.classList.remove("multistep-form-step--active");
    });
    stepEls[stepNumber].classList.add("multistep-form-step--active");
  };
};
