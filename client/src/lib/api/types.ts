export interface League {
  id: number;
  name: string;
  description?: string;
  competitionId: number;
  isPrivate: boolean;
  createdById: number;
  createdAt: Date;
}

export interface Point {
  id: number;
  userLeagueId: number;
  points: number;
  createdAt: Date;
}
