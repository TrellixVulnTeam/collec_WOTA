<?php

/**
 * Created : 24 juin 2016
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2016 - All rights reserved
 */
include_once 'modules/classes/event.class.php';
$dataClass = new Event($bdd, $ObjetBDDParam);
$keyName = "event_id";
$id = $_REQUEST[$keyName];
switch ($t_module["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "gestion/eventChange.tpl", $_REQUEST["uid"]);
		$vue->set($_SESSION["moduleParent"], "moduleParent");
		$vue->set("tab-event", "activeTab");
		/*
		 * Lecture de l'object concerne
		 */
		require_once 'modules/classes/object.class.php';
		$object = new ObjectClass($bdd, $ObjetBDDParam);
		$vue->set($data = $object->lire($_REQUEST["uid"]), "object");

		/*
		 * Recherche des types d'evenement
		 */
		require_once 'modules/classes/eventType.class.php';
		$eventType = new EventType($bdd, $ObjetBDDParam);
		$vue->set($eventType->getListeFromCategory($_SESSION["moduleParent"], $data["collection_id"]), "eventType");

		break;
	case "write":
		/*
		 * write record in database
		 */
		//$dataClass->debug_mode = 2;
		$id = dataWrite($dataClass, $_REQUEST, false);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;
		}
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete($dataClass, $id);
		break;

	case "search":
		$_SESSION["moduleListe"] = "eventSearch";
		$_SESSION["searchEvent"]->setParam($_REQUEST);
		$dataSearch = $_SESSION["searchEvent"]->getParam();
		if ($_SESSION["searchEvent"]->isSearch() == 1) {
			$vue->set(
				$dataClass->searchDueEvent(
					$dataSearch["search_type"],
					$dataSearch["date_from"],
					$dataSearch["date_to"],
					$dataSearch["is_done"],
					$dataSearch["collection_id"],
					$dataSearch["event_type_id"],
					$dataSearch["object_type_id"],
					$dataSearch["object_type"]
				),
				"events"
			);
			$vue->set(1, "isSearch");
		}
		include_once "modules/classes/collection.class.php";
    $collection = new Collection($bdd, $ObjetBDDParam);
    $vue->set($collection->getAllCollections(), "collections");
		include_once "modules/classes/eventType.class.php";
		if ($dataSearch["object_type"]== 1 ) {
			$category = "sample";
		include_once  "modules/classes/sampleType.class.php";
		$sampleType = new SampleType($bdd, $ObjetBDDParam);
		$vue->set($sampleType->getListFromCollection($dataSearch["collection_id"]),"objectTypes");
		} else {
			$category = "container";
			include_once "modules/classes/containerType.class.php";
			$ct = new ContainerType($bdd, $ObjetBDDParam);
			$vue->set($ct->getListe("container_type_name"), "objectTypes");
		}
		$eventType = new EventType($bdd, $ObjetBDDParam);
		$vue->set ($eventType->getListeFromCategory($category, $dataSearch["collection_id"]), "eventTypes");
		$vue->set($dataSearch, "eventSearch");
		$vue->set("gestion/eventSearchList.tpl", "corps");
		break;
}
