function cambiarVentana(idActual, idNueva) {
            if (idActual !== idNueva) {
                document.getElementById(idActual).close();
                document.getElementById(idNueva).showModal();
            }
        }