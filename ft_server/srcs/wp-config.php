<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'root' );

/** MySQL database password */
define( 'DB_PASSWORD', '' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '&N2sCb:sZ)heu>8)HSNLu%>=9ot%?1hMmbj>|dNAC c6J$uFpvpa6QScawCyUawJ' );
define( 'SECURE_AUTH_KEY',  'IOuG%I65|u>/z5&!g_M6}D-k3.l/S (d#v<~_iDu_$2l7R(WffCrHXb(c]cU|*M=' );
define( 'LOGGED_IN_KEY',    '-Nj7jBr/v5^}i_,WwbV>wgfPOi!(i:n^*5cPBr55a62 >$!)|9#a<4FoO~ICg$y-' );
define( 'NONCE_KEY',        '|L_;P3=c{pn.^t/2TBj+J!{2lhg-$Lovecah 4D_~_RWU]$G%c7O5q-ui53JR Xi' );
define( 'AUTH_SALT',        '>j64P~ iQ69rO[54}Nb>2@.wwf?X/2Rd:>i<T9<>P#SiM=/mRCGamfAj]]q|V7/t' );
define( 'SECURE_AUTH_SALT', 'xw>$tNVpvJa@;<HZhfFgB)aDH4JfD*1FV6N2F,rOPV<f*+b$=p~XoJpk}re*T2A)' );
define( 'LOGGED_IN_SALT',   '7Fs;H`!}NA/*?r%J-i>!fRVjS2:/-sS7;A$$D0qd[uJ&4sa`28bRSO~Aw{NWwZ?*' );
define( 'NONCE_SALT',       'A[W-.jN[X94a%?S~fnhGj41hmX|S)U`)fw_dD,(4De udt#<e}8WjeY>nSO&;J|L' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
