'use client';

import { useState } from 'react';
import LeagueHeader from '@/app/leagues/LeagueHeader';

type Props = {
  params: { id: string };
};
const League = ({ params }: Props) => {
  const { id } = params;
  const [activeTab, setActiveTab] = useState('Table');
  const [isFormOpen, setIsFormOpen] = useState(false);

  return (
    <div>
      {/* MODAL FORM */}

      {/* <LeagueHeader activeTab={activeTab} setActiveTab={setActiveTab} /> */}
    </div>
  );
};
export default League;
