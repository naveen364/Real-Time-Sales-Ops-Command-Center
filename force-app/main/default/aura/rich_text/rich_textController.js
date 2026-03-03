({
    myAction : function(component, event, helper) {

    },

    init: function(cmp) {
        var linkifyRichText = cmp.find("linkifyRichText");
        linkifyRichText.set("v.value", "You should be able to navigate with the following links:");
    }
})