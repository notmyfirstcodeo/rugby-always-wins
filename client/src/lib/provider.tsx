'use client';

import StoreContext from './redux';

export default function StoreProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  return <StoreContext>{children}</StoreContext>;
}
