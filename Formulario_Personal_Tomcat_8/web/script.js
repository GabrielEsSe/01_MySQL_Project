function validar_enteros(e){
    let values = "0123456789"
    let key = e.which || e.keyCode;
    let index = String.fromCharCode(key);
    let x = values.indexOf(index);
    if(x === -1){
        e.preventDefault();
        return false;
    }
}
function validar_caracteres(){
    let text = event.key.charCodeAt();
    if((!(text >= 65 && text <= 90)) && (!(text >= 97 && text <=122)) && (!(text == 32)) && (!(text >= 192 && text <= 255)))
        event.returnValue = false;
}
function validar(event){
    event.preventDefault();
    const formuario = document.getElementById("form");
    let boleta = document.getElementById("boleta");
    let nombre = document.getElementById("nombre");
    let combo = document.getElementById("menu");
    let words = combo.options[combo.selectedIndex].value;
    let turno = document.querySelectorAll('input[name="turno"]:checked');
    let checkedBoxes = document.querySelectorAll('input[name="idioma"]:checked');
    

    if(boleta.value === ''){
        alert('ingresa tu boleta');
        boleta.focus();
        return false;
    }
    if(nombre.value === ''){
        alert('Ingresa tu nombre');
        nombre.focus();
        return false;
    }
    if(words === "nada"){
        alert('Selecciona tu especialidad');
        combo.focus();
        return false;
    }
    if(turno.length === 0){
        alert('Seleccione un turno');
        return false;
    }
    if(checkedBoxes.length === 0){
        alert('Debes selecciona un idioma');
        return false;
    }
    alert("Hola" + " " + nombre.value + " " + "tu boleta es: " + " " + boleta.value + " " + "de la especialidad" + " " + combo.value  );
    formuario.submit();

}
function validar_punto(e){
    let values = "0123456789."
    let key = e.keyCode;
    let letra = String.fromCharCode(key);

    let n = values.indexOf(letra);
    if(n === -1){
        e.preventDefault();
        return
    }
    let input = e.target;
    let value = input.value;

    if(letra === "."){
        if(value.indexOf(".") !== -1){
            e.preventDefault();
            return
        }
    }
    
}
function puntero(){
    document.getElementById("boleta").focus();
}