<h2>Détail d'un échantillon</h2>
<div class="row">
<div class="col-md-12">
<a href="index.php?module=sampleList"><img src="display/images/list.png" height="25">Retour à la liste</a>
{if $droits.gestion == 1}
&nbsp;
<a href="index.php?module=sampleChange&uid=0">
<img src="display/images/new.png" height="25">
Nouvel échantillon
</a>
{if $modifiable == 1}
&nbsp;
<a href="index.php?module=sampleChange&uid={$data.uid}">
<img src="display/images/edit.gif" height="25">Modifier...
</a>
{/if}
{/if}

<div class="row">

<fieldset class="col-md-4">
<legend>Informations générales</legend>
<div class="form-display">
<dl class="dl-horizontal">
<dt>UID et référence :</dt>
<dd>{$data.uid} {$data.identifier}</dd>
</dl>
<dl class="dl-horizontal">
<dt>Projet :</dt>
<dd>{$data.project_name}</dd>
</dl>
<dl class="dl-horizontal">
<dt>Type :</dt>
<dd>{$data.sample_type_name}</dd>
</dl>
<dl class="dl-horizontal">
<dt title="Date de création de l'échantillon">Date de création de l'échantillon :</dt>
<dd>{$data.sample_date}</dd>
</dl>
<dl class="dl-horizontal">
<dt title="Date d'import dans la base de données">Date d'import dans la base de données :</dt>
<dd>{$data.sample_creation_date}</dd>
</dl>
<dl class="dl-horizontal">
<dt>Emplacement :</dt>
<dd>
{section name=lst loop=$parents}
<a href="index.php?module=containerDisplay&uid={$parents[lst].uid}">
{$parents[lst].uid} {$parents[lst].identifier} {$container_type_name}
</a>
{if not $smarty.section.lst.last}
<br>
{/if}
{/section}
</dd>
</dl>
</div>
</fieldset>

<div class="col-md-8">

<fieldset>
<legend>Événements</legend>
{include file="gestion/eventList.tpl"}
</fieldset>
<fieldset>
<legend>Mouvements</legend>
{include file="gestion/storageList.tpl"}
</fieldset>

</div>

</div>

</div>
</div>