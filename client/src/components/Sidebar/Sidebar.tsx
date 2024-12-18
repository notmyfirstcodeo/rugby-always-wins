'use client';

import { useEffect, useState } from 'react';
import styles from './sidebar.module.scss';
import { SidebarItems } from './SidebarItems';
import { clsx } from 'clsx';
import SidebarItem from './SidebarItem';
import {
  AlertCircle,
  AlertOctagon,
  AlertTriangle,
  Trophy,
  ChevronDown,
  ChevronUp,
  ChevronLeft,
  Home,
  Layers3,
  LockIcon,
  LucideIcon,
  Target,
  Settings,
  ShieldAlert,
  User,
  BarChart,
  X,
} from 'lucide-react';
import { useGetLeaguesQuery } from '@/lib/api/slice';

const Sidebar = () => {
  const [showLeagues, setShowLeagues] = useState<boolean>(true);
  const sidebarItems = SidebarItems();

  const { data: leagues } = useGetLeaguesQuery();

  const [isSidebarOpen, setIsSidebarOpen] = useState<boolean>(() => {
    if (typeof window !== 'undefined') {
      const saved = window.localStorage.getItem('sidebarOpen');
      if (saved === null) {
        return true;
      }
      return JSON.parse(saved);
    }
    return true;
  });

  useEffect(() => {
    if (typeof window !== 'undefined') {
      window.localStorage.setItem('sidebarOpen', JSON.stringify(isSidebarOpen));
    }
  }, [isSidebarOpen]);

  const toggleSidebar = () => {
    setIsSidebarOpen((prevState) => !prevState);
  };

  return (
    <div
      className={clsx(styles.sidebar, { [styles.sidebarOpen]: isSidebarOpen })}
    >
      <nav className={styles.sidebar__nav}>
        <SidebarItem icon={Home} label='Home' href='/' />
        <SidebarItem icon={Trophy} label='Leagues' href='/leagues' />
        <SidebarItem icon={Target} label='Predictions' href='/predictions' />
        <SidebarItem icon={BarChart} label='Statistics' href='/statistics' />
        <SidebarItem icon={User} label='Profile' href='/profile' />
        <SidebarItem icon={Settings} label='Settings' href='/settings' />
      </nav>

      {/* LEAGUE LINKS */}
      <button
        onClick={() => setShowLeagues((prev) => !prev)}
        className={styles.sidebar__leaguesButton}
      >
        <span>Leagues</span>
        {showLeagues ? (
          <ChevronUp className={styles.sidebar__leaguesButtonUp} />
        ) : (
          <ChevronDown className={styles.sidebar__leaguesButtonDown} />
        )}
      </button>
      {/* LEAGUES LIST */}
      {showLeagues &&
        leagues?.map((league) => (
          <SidebarItem
            key={league.id}
            icon={Trophy}
            label={league.name}
            href={`/leagues/${league.id}`}
          />
        ))}

      {/* Add TOGGLE back in later */}
      {/* <div className={styles.sidebar__toggle}>
        <button
          type='button'
          className={styles.sidebar__toggleWrapper}
          onClick={toggleSidebar}
        >
          <ChevronLeft className={styles.sidebar__toggleIcon} />
        </button>
      </div> */}
    </div>
  );
};

export default Sidebar;
