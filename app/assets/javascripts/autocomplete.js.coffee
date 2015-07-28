jQuery ->
	names_ids = $('#verifier_list').data('verifiers')
	dict = {}
	names = []
	for object in names_ids
		names.push(object.name)
		dict[object.name] = object.id
	$('.verifier-name').each (index, element) =>
    $(element).autocomplete({source: names}, {select: (event, ui) -> $(element).next('input').val(dict[ui.item.value])})


