import { fetchAPI } from './fetch';
import { League } from './types';

export const getLeagues = async (): Promise<League[]> => {
  try {
    const leagues = await fetchAPI<League[]>('/leagues');
    return leagues;
  } catch (error: unknown) {
    if (error instanceof Error) {
      throw new Error(`Failed to fetch leagues: ${error.message}`);
    } else {
      throw new Error('An unknown error occurred');
    }
  }
};
