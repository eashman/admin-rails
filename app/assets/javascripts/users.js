var pretty_json = function (ele, level, key) {
    var cls = [];
    if (key) {
        cls.push('pretty-json-key');
        ele = ele + ':';
    } else if (typeof ele === 'number') {
        cls.push('pretty-json-number');
    } else if (typeof ele === 'boolean' && ele) {
        cls.push('pretty-json-true');
    } else if (typeof ele === 'boolean' && !ele) {
        cls.push('pretty-json-false');
    } else if (typeof ele === 'string') {
        cls.push('pretty-json-string');
    } else {
        cls.push('pretty-json-null');
        ele = '<i class="fa fa-ban"></i>';
    }

    var output = '<span ';
    if (key) output += 'style="margin-left:' + (INDENT * level) + 'px" ';
    output += ('class="' + cls.join(' ') + '">' + ele + '</span>');
    console.log(output);
    return output;
};

var eachRecursive = function (obj, level, s) {
    for (var k in obj) {
        if (!obj.hasOwnProperty(k)) continue;
        if (typeof obj[k] == "object" && obj[k] !== null) {
            s.push(pretty_json(k, level, true));
            s.push("<br>");
            eachRecursive(obj[k], level + 1, s);
        } else {
            s.push(pretty_json(k, level, true));
            s.push(pretty_json(obj[k], level));
            s.push("<br>");
        }
    }
};

var make_pretty_json = function (json_str) {
    var json_obj = JSON.parse(json_str);
    var output = [];
    eachRecursive(json_obj, 1, output);
    return output.join('');
};
