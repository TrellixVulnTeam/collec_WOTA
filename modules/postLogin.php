<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 avr. 2014
 *  Programme execute si necessaire apres identification
 */

/*
 * Suppression des documents de plus de 24 heures dans le dossier temporaire
 */
if (!empty($APPLI_temp)) {
    $dureeVie = 3600 * 24; // Suppression de tous les fichiers de plus de 24 heures
                           // $dureeVie = 30;
    /*
     * Ouverture du dossier
     */
    $dossier = opendir($APPLI_temp);
    while (false !== ($entry = readdir($dossier))) {
        $path = $APPLI_temp . "/" . $entry;
        $file = fopen($path, 'r');
        $stat = fstat($file);
        $atime = $stat["atime"];
        fclose($file);
        $infos = pathinfo($path);
        if (! is_dir($path) && ($infos["basename"] != ".htaccess")) {
            $age = time() - $atime;
            if ($age > $dureeVie) {
                unlink($path);
            }
        }
    }
    closedir($dossier);
}
require_once 'modules/classes/collection.class.php';
$collection = new Collection($bdd, $ObjetBDDParam);
/*
 * Recuperation des collections attaches directement au login
 */
try {
    $collection->initCollections();
} catch (Exception $e) {
    if ($APPLI_modeDeveloppement) {
        $message->set($e->getMessage());
    }
}


?>
