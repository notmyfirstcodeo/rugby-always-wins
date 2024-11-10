import Link from 'next/link';
import styles from './header.module.scss';
import { Search, Settings } from 'lucide-react';

const Header = () => {
  return (
    <header className={styles.header}>
      {/* Search Bar */}
      <div className={styles.header__toolbar}>
        <div className={styles.header__search}>
          <Search className={styles.header__searchIcon} />
          <input
            className={styles.header__searchInput}
            placeholder='Search...'
            type='search'
          />
        </div>
      </div>

      {/* Icons */}
      <div className={styles.header__icons}>
        <Link href="/settings" className={styles.header__settings}>
          <Settings className={styles.header__settingsIcon} />
        </Link>
        <div className={styles.header__iconsDivider}></div>
      </div>
    </header>
  );
};

export default Header;
