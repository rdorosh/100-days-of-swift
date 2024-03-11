var Action = function() {};

Action.prototype = {

run: function(parameters) {

},

finalize: function(parameters) {
    parameters.completionFunction({"URL": document.URL, "title": document.title });
}

};

var ExtensionPreprocessingJS = new Action
