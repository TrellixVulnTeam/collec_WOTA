<h2>Rechercher des conteneurs</h2>
<div class="col_lg_6">
<div class="container-fluid">

{include file='gestion/containerSearch.tpl'}
{if $search.isSearch > 0}
{if $droits.gestion == 1}
<a href="index.php?module=containerChange&container_id=0"><img src="display/images/new.png" height="25">Nouveau conteneur</a>
{/if}
<table id="containerList" class="table table-bordered table-hover datatable " >
<thead>
<tr>
<th>UID</th>
<th>Statut</th>
<th>Type</th>
<th>Condition de stockage</th>
<th>Produit de stockage</th>
<th>Code CLP</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits.gestion == 1}
<a href="index.php?module=containerChange&container_id={$data[lst].container_id}">
{$data[lst].uid}
{else}
{$data[lst].uid}
{/if}
</td>
<td >
{$data[lst].container_status_name}
</td>
<td>
{$data[lst].container_family_name}/
{$data[lst].container_type_name}
</td>
<td>
{$data[lst].storage_condition_name}
</td>
<td>
{$data[lst].storage_product}
</td>
<td>
{$data[lst].clp_classification}
</td>
</tr>
{/section}
</tbody>
</table>

{/if}
</div>
<div class="col_md_6"></div>
</div>