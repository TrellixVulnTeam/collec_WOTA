<script type="text/javascript" src="display/javascript/alpaca/js/defineForm.js"></script>

<script type="text/javascript">
function loadSchema(){
    var $metadataFormId = document.getElementById("copySchema").value;
    {section name=lst loop=$metadata}
        if ($metadataFormId == {$metadata[lst].metadata_form_id}){
            var $schemaCopy = "{$metadata[lst].schema}";
            $schemaCopy = $schemaCopy.replace(/&quot;/g,'"');
            $schemaCopy = JSON.parse($schemaCopy);

            $("#metadata").alpaca("destroy");
            renderForm($schemaCopy);
        }
    {/section}
}
</script>

{if $nbSample>0}
<div class="col-md-12 message">
<span class="red"> Cette opération n'est pas modifiable, car il existe des échantillons qui lui sont associés.</span>
</div>
<br/>
<input type="button" class="btn btn-primary button-valid" value="En créer une nouvelle version" onclick="location.href='index.php?module=operationChange&operation_id=0&operation_pere_id={$data.operation_id}'">

{/if}

<h2>Modification d'une operation</h2>
<div class="row">
<div class="col-md-6">
<a href="index.php?module=operationList">{$LANG.appli.1}</a>

<form class="form-horizontal protoform" id="operationForm" method="post" action="index.php" >
<input type="hidden" name="moduleBase" value="operation">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="operation_id" value="{$data.operation_id}">
<input type="hidden" name="metadata_form_id" value="{$data.metadata_form_id}">
<input type="hidden" name="metadataField" id="metadataField">
<div class="form-group">
<label for="protocolId"  class="control-label col-md-4">Protocole<span class="red">*</span> :</label>
<div class="col-md-8">
<select id="protocolId" name="protocol_id" class="form-control" autofocus>
{section name=lst loop=$protocol}
<option value="{$protocol[lst].protocol_id}" {if $data.protocol_id == $protocol[lst].protocol_id}selected{/if}>
{$protocol[lst].protocol_year} {$protocol[lst].protocol_name} {$protocol[lst].protocol_version}
</option>
{/section}
</select>
</div>
</div>

<div class="form-group">
<label for="operationName"  class="control-label col-md-4">Nom de l'opération<span class="red">*</span> :</label>
<div class="col-md-8">
<input id="operationName" type="text" class="form-control" name="operation_name" value="{if $operation_pere_id>0}{section name=lst loop=$operations}{if $operations[lst].operation_id == $operation_pere_id}{$operations[lst].operation_name}{/if}{/section}{else}{$data.operation_name}{/if}" required>
</div>
</div>

<div class="form-group">
<label for="operationVersion"  class="control-label col-md-4">Version de l'opération<span class="red">*</span> :</label>
<div class="col-md-8">
<input id="operationVersion" type="text" class="form-control" name="operation_version" value="{$data.operation_version}" required>
</div>
</div>

<div class="form-group">
<label for="operationOrder"  class="control-label col-md-4">N° d'ordre :</label>
<div class="col-md-8">
<input id="operationOrder" type="number" class="form-control" name="operation_order" value="{$data.operation_order}">
</div>
</div>



    <legend>Jeu de métadonnées</legend>
<div class="form-group">
    <label for="copySchema"  class="control-label col-md-4">Partir d'un schéma existant :</label>
    <div class="col-md-8">
    <select id="copySchema" name="copySchema" class="form-control" onChange="loadSchema()" autofocus>
    {section name=lst loop=$operations}
    <option value="{$operations[lst].metadata_form_id}">
    {$operations[lst].operation_name}
    </option>
    {/section}
    </select>
    </div>
</div>

    <div id="metadata"></div>



<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{$LANG["message"].19}</button>
      {if $data.operation_id > 0 }
      <button class="btn btn-danger button-delete">{$LANG["message"].20}</button>
      {/if}
 </div>
</form>
</div>
</div>
<span class="red">*</span><span class="messagebas">{$LANG["message"].36}</span>


<script type="text/javascript">
    $(document).ready(function() {

        var $metadataParse="";
        {section name=lst loop=$metadata}
        {if $metadata[lst].metadata_form_id == $data.metadata_form_id}
        $metadataParse = "{$metadata[lst].schema}";
        $metadataParse = $metadataParse.replace(/&quot;/g,'"');
        $metadataParse = JSON.parse($metadataParse);
        {/if}
        {/section}
        
        renderForm($metadataParse);
        
    });
</script>