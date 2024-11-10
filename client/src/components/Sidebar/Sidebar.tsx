'use client';

import { useState } from 'react';
import styles from './sidebar.module.scss';

const Sidebar = () => {
  const [showLeagues, setShowLeagues] = useState(true);

  return (
    <div className={styles.sidebar}>
      <div className={styles.sidebar__logo}>
        <div className={styles.sidebar__logoWrapper}></div>
      </div>
    </div>
  );
};

export default Sidebar;
