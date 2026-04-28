(function(){
  var DURACION_TOTAL_SEG = 15 * 60;
  var UMBRAL_AMARILLO_MIN = 10;
  var UMBRAL_ROJO_MIN = 15;

  var visibles = new Set();
  var observer = null;

  function dosDigitos(n){
    return (n < 10 ? '0' : '') + n;
  }

  function aplicarClase(el, clase){
    if (!el) return;
    if (clase === 'timer-rojo') {
      if (!el.classList.contains('timer-rojo')) {
        el.classList.remove('timer-amarillo');
        el.classList.add('timer-rojo');
      }
    } else if (clase === 'timer-amarillo') {
      if (!el.classList.contains('timer-amarillo')) {
        el.classList.remove('timer-rojo');
        el.classList.add('timer-amarillo');
      }
    } else {
      el.classList.remove('timer-amarillo');
      el.classList.remove('timer-rojo');
    }
  }

  function actualizarUno(el){
    var inicioStr = el.getAttribute('data-inicio');
    if (!inicioStr) return;

    var inicio = new Date(inicioStr).getTime();
    if (isNaN(inicio)) return;

    var transcurrido = Math.floor((Date.now() - inicio) / 1000);
    if (transcurrido < 0) transcurrido = 0;

    var minutos = Math.floor(transcurrido / 60);
    var segundos = transcurrido % 60;

    var textoEl = el.querySelector('.cronometro-texto');
    if (textoEl) {
      textoEl.textContent = dosDigitos(minutos) + ':' + dosDigitos(segundos);
    }

    var progresoEl = el.querySelector('.cronometro-progreso');
    if (progresoEl) {
      var porcentaje = (transcurrido / DURACION_TOTAL_SEG) * 100;
      if (porcentaje > 100) porcentaje = 100;
      progresoEl.style.width = porcentaje + '%';
    }

    var clase = null;
    if (minutos >= UMBRAL_ROJO_MIN) clase = 'timer-rojo';
    else if (minutos >= UMBRAL_AMARILLO_MIN) clase = 'timer-amarillo';

    aplicarClase(el, clase);
    var fila = el.closest ? el.closest('tr') : null;
    aplicarClase(fila, clase);
  }

  function actualizarVisibles(){
    visibles.forEach(function(el){
      // Limpia referencias a elementos que Angular ya removio del DOM
      if (typeof el.isConnected === 'boolean' && !el.isConnected) {
        visibles.delete(el);
        return;
      }
      actualizarUno(el);
    });
  }

  function marcarFueraPantalla(el, fuera){
    if (fuera) {
      el.classList.add('fuera-pantalla');
    } else {
      el.classList.remove('fuera-pantalla');
    }
    var fila = el.closest ? el.closest('tr') : null;
    if (fila) {
      if (fuera) fila.classList.add('fuera-pantalla');
      else fila.classList.remove('fuera-pantalla');
    }
  }

  function configurarObserver(){
    if (!('IntersectionObserver' in window)) return;
    observer = new IntersectionObserver(function(entries){
      for (var i = 0; i < entries.length; i++) {
        var entry = entries[i];
        var el = entry.target;
        if (entry.isIntersecting) {
          visibles.add(el);
          marcarFueraPantalla(el, false);
          // Refresca de inmediato al entrar a pantalla para que no se vea desfasado
          actualizarUno(el);
        } else {
          visibles.delete(el);
          marcarFueraPantalla(el, true);
        }
      }
    }, {
      // Pequeno margen para que filas justo afuera tambien se actualicen
      rootMargin: '300px 0px'
    });
  }

  function observarNuevos(){
    if (!observer) return;
    var elementos = document.querySelectorAll('.cronometro-cocina:not([data-observado])');
    for (var i = 0; i < elementos.length; i++) {
      var el = elementos[i];
      el.setAttribute('data-observado', '1');
      // Por defecto fuera de pantalla hasta que el IO confirme lo contrario
      marcarFueraPantalla(el, true);
      observer.observe(el);
    }
  }

  function fallbackTodos(){
    var elementos = document.querySelectorAll('.cronometro-cocina');
    for (var i = 0; i < elementos.length; i++) {
      actualizarUno(elementos[i]);
    }
  }

  configurarObserver();

  setInterval(function(){
    if (observer) {
      observarNuevos();
      actualizarVisibles();
    } else {
      fallbackTodos();
    }
  }, 1000);

  document.addEventListener('DOMContentLoaded', observarNuevos);
  document.addEventListener('turbolinks:load', observarNuevos);
})();
