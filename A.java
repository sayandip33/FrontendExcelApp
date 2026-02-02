(function () {

  const idleDurationSecs = 15;
  let idleTimeout;

  const resetIdleTimeout = function () {

    if (idleTimeout) clearTimeout(idleTimeout);

    idleTimeout = setTimeout(() => {
      window.location.href = "logout";
    }, idleDurationSecs * 1000);
  };

  resetIdleTimeout();

  ['click', 'touchstart', 'mousemove'].forEach(evt =>
    document.addEventListener(evt, resetIdleTimeout, false)
  );

})();
