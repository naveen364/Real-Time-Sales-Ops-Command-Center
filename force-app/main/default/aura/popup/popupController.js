({
	show_model : function(component, event, helper) {
		 var elements = document.getElementsByClassName("modal");
        	elements[0].style.display = 'block';
        var elements1 = document.getElementsByClassName("overlay");
        	elements1[0].style.display = 'block';
	},
    closebtn : function(component, event, helper) {
       	var elements = document.getElementsByClassName("modal");
        	elements[0].style.display = 'none';
        var elements1 = document.getElementsByClassName("overlay");
        	elements1[0].style.display = 'none';
	}
})