import Link from 'next/link';
import styles from './header.module.scss';
import { Search, Settings } from 'lucide-react';

const Header = () => {
  return (
    <header className={styles.header}>
      {/* Logo */}
      <Link href='#' className={styles.header__logo} prefetch={false}>
        <h1 className={styles.header__logoText}>Rugby Always Wins</h1>
      </Link>

      {/* Icons */}
      <div className={styles.header__icons}>
        <Link href='/settings' className={styles.header__settings}>
          <Settings className={styles.header__settingsIcon} />
        </Link>
        <div className={styles.header__iconsDivider}></div>
      </div>
    </header>
  );
};

export default Header;
