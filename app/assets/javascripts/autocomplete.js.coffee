jQuery ->
	names_ids = $('#verifier_list').data('verifiers')
	dict = {}
	names = []
	for object in names_ids
		names.push(object.name)
		dict[object.name] = object.id
	$('#verifier_name').autocomplete({source: names}, {select: (event, ui) -> $('#verifier').val(dict[ui.item.value])})


