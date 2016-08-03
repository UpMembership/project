<?php
/**
 * @file
 * Enables modules and site configuration for a standard site installation.
 */

 use Drupal\Core\Config\FileStorage;
 use Drupal\Core\Config\InstallStorage;

/**
 * Implements hook_install_tasks().
 */


/**
 * Batch API callback. Installs a module.
 *
 * @param string|array $module
 *   The name(s) of the module(s) to install.
 */
function upmembership_install_module($module) {
  \Drupal::service('module_installer')->install((array) $module);
}

/**
 * Rebuilds the service container.
 */
function upmembership_rebuild_container() {
  require_once \Drupal::root() . '/core/includes/utility.inc';
  $class_loader = \Drupal::service('class_loader');
  $request = \Drupal::request();
  drupal_rebuild($class_loader, $request);
}

/**
 * Reads a stored config file from a module's config/install directory.
 *
 * @param string $id
 *   The config ID.
 * @param string $module
 *   (optional) The module to search. Defaults to 'upmembership' (not technically
 *   a module, but profiles are treated like modules by the install system).
 *
 * @return array
 *   The config data.
 */
function upmembership_read_config($id, $module = 'upmembership') {
  // Statically cache all FileStorage objects, keyed by module.
  static $storage = [];

  if (empty($storage[$module])) {
    $dir = \Drupal::service('module_handler')->getModule($module)->getPath();
    $storage[$module] = new FileStorage($dir . '/' . InstallStorage::CONFIG_INSTALL_DIRECTORY);
  }
  return $storage[$module]->read($id);
}
