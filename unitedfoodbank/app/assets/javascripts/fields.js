//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require libs/bootstrap
//= require libs/select2
//= require libs/bootstrap-multiselect

United = {}
United.blank = function(value){
	if(typeof value === "undefined" || value == null || (typeof value === "string" && value == "")){
		return true;
	}
	return false;
}

$(document).ready(function(){
	$('input[name="field[type]"]').change(function(el){
			var self = this;
			if($(self).val()=="single_select" || $(self).val()=="multi_select"){
				multiple = true;
				$('input[name="field[data]"]').closest('.form-group').removeClass('hidden');
			    $('input[name="field[data]"]').select2({
					data: [],
					multiple: multiple,
					placeholder: "select",
					initSelection: function initSelection(element, callback) {
						var data;
						if(multiple){
							data = [];
							if(!United.blank(element.val())){
								for(count = 0; count < element.val().split(",").length; count++){
									val = element.val().split(",")[count];
									data.push({id: val, text: val});
								}
						    }
					    }else{
					    	data = { id: element.val(), text: element.val() };
					    }
					    callback(data);
				    },
					createSearchChoice: function(term, data) {
						if( $(data).filter( function() {
			           		return this.text.localeCompare(term)===0;
			         	}).length===0) {
			         		return {id:term, text:term};
			         	}
			       	}
			    });
			}
		});
	$('input[name="field[type]"]').trigger('change');
});