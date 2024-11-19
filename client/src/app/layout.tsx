import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import '../styles/main.scss';
import Header from '@/components/Header/Header';
import Sidebar from '@/components/Sidebar/Sidebar';
import StoreProvider from './StoreProvider';

const inter = Inter({ subsets: ['latin'] });

export const metadata: Metadata = {
  title: 'Rugby Always Wins',
  description: 'How close can you get?',
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang='en'>
      <body className={inter.className}>
        <StoreProvider>
          <Header />
          <main>
            <Sidebar />
            {children}
          </main>
        </StoreProvider>
      </body>
    </html>
  );
}
