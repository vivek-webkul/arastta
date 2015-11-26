<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
		<a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-success"><i class="fa fa-plus"></i></a>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
		  <div class="pull-right">
			<button type="button" data-toggle="tooltip" title="<?php echo $button_show_filter; ?>" class="btn btn-primary btn-sm" id="showFilter"><i class="fa fa-eye"></i></button>
			<button type="button" data-toggle="tooltip" title="<?php echo $button_hide_filter; ?>" class="btn btn-primary btn-sm" id="hideFilter"><i class="fa fa-eye-slash"></i></button>
		  </div>		
      </div>
      <div class="panel-body">
	   <div class="well" style="display:none;">
        <div class="row">
          <div class="col-lg-12">
            <div class="input-group">
              <div class="input-group-btn">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <span class="caret"></span>
                </button>
                <button type="button" onclick="filter();" class="btn btn-default"><div class="filter-type"><?php echo $column_name; ?></div></button>
                <ul class="dropdown-menu">
                  <li><a class="filter-list-type" onclick="changeFilterType('<?php echo $column_name; ?>', 'filter_name');"><?php echo $column_name; ?></a></li>
                  <li><a class="filter-list-type" onclick="changeFilterType('<?php echo $column_status; ?>', 'filter_status');"><?php echo $column_status; ?></a></li>
                </ul>
              </div>
              <input type="text" name="filter_name"  value="<?php echo $filter_name; ?>" id="input-name" class="form-control filter">
              <select name="filter_status" id="input-status" class="form-control filter hidden">
                <option value="*"></option>
                <?php if ($filter_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <?php } ?>
                <?php if (!$filter_status && !is_null($filter_status)) { ?>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </div>
      </div>
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-manufacturer">
        <div class="table-responsive">
          <table class="table table-hover ">
            <thead class="table-name">
              <tr>
                <td style="width: 70px;" class="text-center">
                  <div class="bulk-action">
                    <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" />
                      <span>
                        <i class="fa fa-caret-down"></i>
                      </span>
                  </div></td>
                <td class="text-left"><?php if ($sort == 'name') { ?>
                  <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                  <?php } ?></td>
			          <td class="text-right"><?php if ($sort == 'status') { ?>
                  <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                  <?php } ?></td>
              </tr>
            </thead>
            <thead class="table-quick-edit">
            <tr>
              <td style="width: 70px;" class="text-center">
                <div class="bulk-action-activate">
                  <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" />
                  <span class="item-selected"></span>
                      <span class="bulk-action-button">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                          <b><?php echo $text_bulk_action; ?></b>
                          <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-left alerts-dropdown">
                          <li class="dropdown-header"><?php echo $text_bulk_action; ?></li>
                          <li><a onclick="changeStatus(1)"><i class="fa fa-check-circle text-success"></i> <?php echo $button_enable; ?></a></li>
                          <li><a onclick="changeStatus(0)"><i class="fa fa-times-circle text-danger"></i> <?php echo $button_disable; ?></a></li>
                          <li><a onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-product').submit() : false;"><i class="fa fa-trash-o"></i> <?php echo $button_delete; ?></a></li>
                        </ul>
                      </span>
                </div>
              </td>
              <td class="text-left">
                <?php echo $column_name; ?></td>
            </tr>
            </thead>
            <tbody>
              <?php if ($manufacturers) { ?>
              <?php foreach ($manufacturers as $manufacturer) { ?>
              <tr>
                <td class="text-center"><?php if (in_array($manufacturer['manufacturer_id'], $selected)) { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $manufacturer['manufacturer_id']; ?>" checked="checked" />
                  <?php } else { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $manufacturer['manufacturer_id']; ?>" />
                  <?php } ?></td>
                <td class="text-left">
                  <a href="<?php echo $manufacturer['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>"><i class="fa fa-pencil"></i></a>
                  <span class="manufacturer-name" id="name[<?php echo $manufacturer['manufacturer_id']; ?>]"><?php echo $manufacturer['name']; ?></span>
                </td>
				<td class="text-right">
                  <span class="manufacturer-status" data-prepend="<?php echo $text_select; ?>" data-source="{'1': '<?php echo $text_enabled; ?>', '0': '<?php echo $text_disabled; ?>'}"><?php echo $manufacturer['status']; ?></span>
                </td>
              </tr>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="text-center" colspan="3"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        </div>
      </form>
      <div class="row">
        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
      </div>
     </div>
    </div>
  </div>
</div>
<style>
  .table.table-hover td {
    height: 67px;
  }

  .table-quick-edit > tr > td {
    vertical-align: bottom;
    border-bottom: 0px solid #dddddd !important;
    border-top: 0px solid #dddddd !important;
    display: none;
  }

  .table-quick-edit td {
    color: #FFF;
  }

  .item-selected {
    position: absolute;
    color: #000;
    padding-top: 5px;
    padding-left: 35px;
    border: 1px solid #ddd;
    border-radius: 3px;
    border-bottom-right-radius: 0;
    border-top-right-radius: 0;
    padding-right: 10px;
    height: 26px;
    margin-left: -27px;
    margin-top: -1px;
  }

  .bulk-action {
    border: 1px solid #ddd;
    border-radius: 3px;
    -webkit-appearance: none!important;
    -moz-appearance: none!important;
  }

  .bulk-action-activate {
    -webkit-appearance: none!important;
    -moz-appearance: none!important;
    border: 1px solid #ffffff;
  }

  .bulk-action-activate input[type="checkbox"] {
    margin-top: 5px;
  }

  .bulk-action-button a {
    margin-top: -5px;
  }

  .bulk-action-activate input[type="checkbox"] {
    z-index: 999;
  }

  .bulk-action-button {
    position: absolute;
    margin-left: 142px;
    height: 26px;
    margin-top: -1px;
    padding-top: 5px;
    border: 1px solid #ddd;
    border-bottom-right-radius: 3px;
    border-top-right-radius: 3px;
    width: 100px;
  }

  .bulk-action i {
    position: absolute;
    margin-left: 9px;
    margin-top: 6px;
    font-size: 12px;
  }

  input[type="radio"],
  .radio input[type="radio"],
  .radio-inline input[type="radio"],
  input[type="checkbox"],
  .checkbox input[type="checkbox"],
  .checkbox-inline input[type="checkbox"] {
    margin-left: -15px;
    width: 15px !important;
    height: 15px !important;
  }

  input[type="checkbox"]:checked::after,
  .checkbox input[type="checkbox"]:checked::after,
  .checkbox-inline input[type="checkbox"]:checked::after {
    top: -4px !important;
  }

  .bulk-action-image {
    width: 50px;
    height: 50px;
  }
</style>
<script type="text/javascript"><!--
function changeStatus(status){
	$.ajax({
		url: 'index.php?route=common/edit/changeStatus&type=manufacturer&status='+ status +'&token=<?php echo $token; ?>',
		dataType: 'json',
		data: $("form[id^='form-']").serialize(),
		success: function(json) {
			if(json){
				$('.panel.panel-default').before('<div class="alert alert-warning"><i class="fa fa-warning"></i> ' + json.warning + '<button type="button" class="close" data-dismiss="alert">×</button></div>');
			}
			else{
				location.reload();
			}
		}
	});
}

//--></script>
<script type="text/javascript"><!--
$(document).ready(function() {
  $.fn.editable.defaults.mode = 'inline';

  $('.manufacturer-name').editable({
    url: function (params) {
      $.ajax({
        type: 'post',
        url: 'index.php?route=catalog/manufacturer/inline&token=<?php echo $token; ?>&manufacturer_id=' + $(this).parent().parent().find( "input[name*=\'selected\']").val(),
        data: {name: params.value},
        async: false,
        error: function (xhr, ajaxOptions, thrownError) {
          return false;
        }
      })
    },
    showbuttons: false,
  });

  $('.manufacturer-status').editable({
    type: 'select',
    url: function (params) {
      $.ajax({
        type: 'post',
        url: 'index.php?route=catalog/manufacturer/inline&token=<?php echo $token; ?>&manufacturer_id=' + $(this).parent().parent().find( "input[name*=\'selected\']").val(),
        data: {status: params.value},
        async: false,
        error: function (xhr, ajaxOptions, thrownError) {
          return false;
        }
      })
    },
    showbuttons: false,
  });

  $('input[type=\'checkbox\']').click (function() {
    var checkboxs = $('#form-manufacturer input[type=\'checkbox\']');
    var selected = 0;

    $.each(checkboxs, function( index, value ) {
      var thisCheck = $(value);

      if (thisCheck.is(':checked')) {
        selected = selected + 1;
      }
    });

    if (selected) {
      $('.table-name').hide();
      $('.table-quick-edit tr td').show();
      $('.item-selected').html(selected + ' <?php echo $text_selected_manufacturer; ?>');
    } else {
      $('.table-name').show();
      $('.table-quick-edit tr td').hide();
    }
  });
});
//--></script>
<script type="text/javascript"><!--
function filter() {
    url = 'index.php?route=catalog/manufacturer&token=<?php echo $token; ?>';

    var filter_name = $('input[name=\'filter_name\']').val();

    if (filter_name) {
        url += '&filter_name=' + encodeURIComponent(filter_name);
    }

    var filter_status = $('select[name=\'filter_status\']').val();

    if (filter_status != '*') {
        url += '&filter_status=' + encodeURIComponent(filter_status);
    }

    location = url;
}

function changeFilterType(text, filter_type) {
  $('.filter-type').text(text);

  $('.filter').addClass('hidden');
  $('input[name=\'' + filter_type + '\']').removeClass('hidden');
  $('select[name=\'' + filter_type + '\']').removeClass('hidden');
}

$('input[name=\'filter_name\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/manufacturer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
                        label: item['name'],
                        name: item['name'],
                        value: item['manufacturer_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'filter_name\']').val(item['name']);
	}
});
//--></script>
<?php echo $footer; ?>
<link href="view/javascript/bootstrap3-editable/css/bootstrap-editable.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="view/javascript/bootstrap3-editable/js/bootstrap-editable.js" ></script>