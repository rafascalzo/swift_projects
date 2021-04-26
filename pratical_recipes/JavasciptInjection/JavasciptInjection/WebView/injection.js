
var backgroundColor = document.getElementById("bg");

backgroundColor.addEventListener("input", function () {
    var theInput = document.getElementById("bg");
    var hexColor = theInput.value;
    var r = hexToRgb(hexColor).r;
    var g = hexToRgb(hexColor).g;
    var b = hexToRgb(hexColor).b;
    document.querySelector('body').style.backgroundColor = 'rgb(' + [r, g, b].join(',') + ')';
}, false);

var titleColor = document.getElementById("titleColor");

titleColor.addEventListener("input", function () {
    var theInput = document.getElementById("titleColor");
    var hexColor = theInput.value;
    var r = hexToRgb(hexColor).r;
    var g = hexToRgb(hexColor).g;
    var b = hexToRgb(hexColor).b;

    var title = document.getElementById('title');
    title.style.color = 'rgb(' + [r, g, b].join(',') + ')';
}, false);

var iconColor = document.getElementById('iconColor');
iconColor.addEventListener("input", function () {
    var inputColor = document.getElementById('iconColor');
    var hexColor = inputColor.value
    var r = hexToRgb(hexColor).r;
    var g = hexToRgb(hexColor).g;
    var b = hexToRgb(hexColor).b;

    var iconStyle = document.getElementsByClassName('logo');
    for (var i = 0; i < iconStyle.length; i++) {
        iconStyle[i].style.fill = 'rgb(' + [r, g, b].join(',') + ')';
    }
}, false);

var fontColor = document.getElementById('fontColor');

fontColor.addEventListener("input", function () {
    var inputColor = document.getElementById('fontColor');
    var hexColor = inputColor.value
    var r = hexToRgb(hexColor).r;
    var g = hexToRgb(hexColor).g;
    var b = hexToRgb(hexColor).b;

    var texts = document.getElementsByClassName('text');
    for (var i = 0; i < texts.length; i++) {
        texts[i].style.color = 'rgb(' + [r, g, b].join(',') + ')';
    }
}, false)

var buttonColor = document.getElementById('buttonColor');

buttonColor.addEventListener("input", function () {
    var inputColor = document.getElementById('buttonColor');
    var hexColor = inputColor.value
    var r = hexToRgb(hexColor).r;
    var g = hexToRgb(hexColor).g;
    var b = hexToRgb(hexColor).b;

    Array.from(document.querySelectorAll('button')).map(function (button) {
        button.style.backgroundColor = 'rgb(' + [r, g, b].join(',') + ')';
    })

}, false)

function hexToRgb(hex) {
    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
        r: parseInt(result[1], 16),
        g: parseInt(result[2], 16),
        b: parseInt(result[3], 16)
    } : null;
}

function changeTitlesColor() {
    var h1Elements = document.getElementsByTagName("h1");

    for (var i = 0; i < h1Elements.length; i++) {
        h1Elements[i].style.color = hexColor;
    }
}

function showAlert() {
    alert('Yaurr');
}

function changeButtonColor() {
    document.getElementsByTagName('button').style.backgroundColor = "green";
}

function sum(m, n) {
    result = Number(m) + Number(n);
    document.getElementById('result').innerHTML = result;
    return a + b
}
var result;

function square(a, b) {
    result = a;
    for (i = 1; i < b, i++;) {
        result *= result;
    }
    return result
}

function remainder(m, n) {
    result = Number(m) % Number(n);
    document.getElementById('result').innerHTML = result;
    return m % n;
}

function subtract(m, n) {
    result = Number(m) - Number(n);
    document.getElementById('result').innerHTML = result;
    return m - n;
}

function divide(m, n) {
    result = Number(m) / Number(n);
    document.getElementById('result').innerHTML = result;
    return m / n;
}
