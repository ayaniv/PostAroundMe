Array.prototype.max = function () {
    var max = this[0];
    var len = this.length;
    for (var i = 1; i < len; i++) if (this[i] > max) max = this[i];
    return max;
}
Array.prototype.min = function () {
    var min = this[0];
    var len = this.length;
    for (var i = 1; i < len; i++) if (this[i] < min) min = this[i];
    return min;
}
String.prototype.ReplaceAll = function (stringToFind, stringToReplace) {
    var temp = this;
    var index = temp.indexOf(stringToFind);
    while (index != -1) {
        temp = temp.replace(stringToFind, stringToReplace);
        index = temp.indexOf(stringToFind);
    }
    return temp;
}

Date.prototype.addHours = function (h) {
    this.setHours(this.getHours() + h);
    return this;
}


String.prototype.trim = function () {
    return this.replace(/^\s+|\s+$/g, "");
}
String.prototype.ltrim = function () {
    return this.replace(/^\s+/, "");
}
String.prototype.rtrim = function () {
    return this.replace(/\s+$/, "");
}

String.prototype.startsWith = function (str) {
    return this.slice(0, str.length) == str;
};

