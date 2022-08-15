--Selecting all values from the CovidDeaths Table ordering it by 3,4
SELECT *
FROM CovidPortfolioProject..CovidDeaths$
Where continent is not null
Order by 3,4

--Selecting all values from the covidvaccinations table ordering it by 3,4
SELECT *
FROM CovidPortfolioProject..CovidVaccinations$
Where continent is not null
Order by 3,4 

Select location, date, total_cases, new_cases, total_deaths, population
From CovidPortfolioProject..CovidDeaths$
Where continent is not null
order by 1,2

--Considering the totalcases vs totaldeaths
--Showing the likelihood of dying based off a particular location
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From CovidPortfolioProject..CovidDeaths$
Where location like '%Nigeria%' 
and continent is not null
order by 1,2

--Total Cases vs Population
--Showing what percentage of the population has covid
Select location, date, population, total_cases, (total_cases/population)*100 as PercentofPopulationInfected
From CovidPortfolioProject..CovidDeaths$
Where location like '%Nigeria%'
order by 1,2

--Looking at countries with highest infection rate compared with population
Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentofPopulationInfected
From CovidPortfolioProject..CovidDeaths$
--Where location like '%Nigeria%'
Group by location, population
order by PercentofPopulationInfected desc


--BREAKING IT UP BY CONTINENT

--Showing countries with the Highest Death Count per population
Select continent, MAX(cast(total_deaths as int)) as HighestDeathCount
From CovidPortfolioProject..CovidDeaths$
--Where location like '%Nigeria%'
Where continent is not null
Group by continent
order by HighestDeathCount desc


--GLOBAL NUMBERS
Select SUM(new_cases)as totalcases, SUM(cast(new_deaths as int)) as totaldeaths, SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
From CovidPortfolioProject..CovidDeaths$
--where location like'%Nigeria%'
where continent is not null
--Group by date
Order by 1,2 


--Looking at Total Population vs Vaccinations
--Knowing people in a partifular location, country that are vaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/Population) *100 
From CovidPortfolioProject..CovidDeaths$ dea
join CovidPortfolioProject..CovidVaccinations$ vac
	on dea.location = vac.location 
	and dea.date = vac.date
Where dea.continent is not null
order by 2,3



--USING CTE
With PopsVsVac (Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/Population) *100 
From CovidPortfolioProject..CovidDeaths$ dea
join CovidPortfolioProject..CovidVaccinations$ vac
	on dea.location = vac.location 
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population) *100
FROM PopsVsVac

--USING TABLE
DROP Table if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar (255),
Date datetime,
Population numeric, 
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/Population) *100 
From CovidPortfolioProject..CovidDeaths$ dea
join CovidPortfolioProject..CovidVaccinations$ vac
	on dea.location = vac.location 
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3

Select *, (RollingPeopleVaccinated/Population) *100
FROM #PercentPopulationVaccinated



--CREATING VIEWS TO STORE DATA FOR LATER VISUALIZATIONS
Create view PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/Population) *100 
From CovidPortfolioProject..CovidDeaths$ dea
join CovidPortfolioProject..CovidVaccinations$ vac
	on dea.location = vac.location 
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3

--IN Order to see the view table you have made
Select *
from PercentPopulationVaccinated
