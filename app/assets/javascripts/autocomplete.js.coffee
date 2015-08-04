jQuery ->
  verifierList = $('#verifier_list')
  if verifierList.length != 0
    names_ids = verifierList.data('verifiers')
    dict = {}
    names = []
    for object in names_ids
      names.push(object.name)
      dict[object.name] = object.id
    $('.verifier-name').each (index, element) =>
      $(element).autocomplete({source: names}, {select: (event, ui) -> $(element).next('input').val(dict[ui.item.value])})


