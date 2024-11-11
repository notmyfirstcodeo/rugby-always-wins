import { LucideIcon } from 'lucide-react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import styles from './sidebar.module.scss';
import clsx from 'clsx';

interface SidebarLinkProps {
  label: string;
  href: string;
  icon: LucideIcon;
}

const SidebarItem = ({ label, href, icon: Icon }: SidebarLinkProps) => {
  const pathname = usePathname();
  const isActive =
    pathname === href || (pathname === '/' && href === '/dashboard');

  return (
    <Link
      href={href}
      className={clsx(styles.sidebar__item, {
        [styles.itemActive]: isActive,
      })}
    >
      {isActive && <div className={styles.sidebar__highlight} />}
      <Icon className={styles.sidebar__icon} />
      <span className={styles.sidebar__iconLabel}>{label}</span>
    </Link>
  );
};
export default SidebarItem;
