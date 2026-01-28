import '../styles/interfaces/AntagInfoFlockAgent.scss';

import { useState } from 'react';
import {
  Box,
  Button,
  DmIcon,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { logger } from '../logging';

type IconParams = {
  icon: string;
  state: string;
  frame: number;
  dir: number;
  moving: BooleanLike;
};

type Recipe = {
  path: string;
  name: string;
  icon_params: IconParams;
  cost: number;
  desc: string;
};

type Info = {
  resources: number;
  lord_name: string;
  recipes: Recipe[];
};

type BriefingProps = {
  lordName: string;
};

const BriefingSection = (props: BriefingProps) => {
  const { lordName } = props;
  return (
    <Stack>
      <Stack.Item grow>
        <Section title="ARISE MY EMISSARY" fill fontSize="16px">
          <Stack vertical>
            <LordBriefing lordName={lordName} />
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

type LordBriefingProps = {
  lordName: string;
};

const LordBriefing = (props: LordBriefingProps) => {
  const { lordName } = props;
  return (
    <Stack.Item>
      <Stack vertical textAlign="center" fontSize="14px">
        <Stack.Item fontSize="20px">
          I AM LORD {lordName.toUpperCase()}
        </Stack.Item>
        <Stack.Item fontSize="16px">AND YOU ARE MY AGENT</Stack.Item>
        <Stack.Item>
          Obey your directives and blah blah. I'm bored. Mess stuff up.
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

type RecipesProps = {
  resources: number;
  recipes: Recipe[];
};

const RecipesSection = (props: RecipesProps) => {
  const { resources, recipes } = props;
  return (
    <Section title="Available Templates" fill scrollable>
      <Stack vertical>
        <Stack.Item textAlign="center" fontSize="14px">
          You have <span style={{ fontSize: '16px' }}>{resources}</span>{' '}
          resources
        </Stack.Item>
        <Stack.Divider />
        {recipes.length === 0
          ? 'None!'
          : recipes.map((recipe, i) => {
              const enabled = resources >= recipe.cost;
              return (
                <Stack.Item key={i}>
                  <Stack
                    justify="center"
                    align="center"
                    backgroundColor="transparent"
                    wrap="wrap"
                  >
                    <RecipeNode recipe={recipe} enabled={enabled} />
                  </Stack>
                </Stack.Item>
              );
            })}
      </Stack>
    </Section>
  );
};

type RecipeNodeProps = {
  recipe: Recipe;
  enabled: BooleanLike;
};

const RecipeNode = (props: RecipeNodeProps) => {
  const { recipe, enabled } = props;
  const { act } = useBackend<Info>();

  return (
    <Stack.Item key={recipe.name}>
      <Button
        color="transparent"
        tooltip={`${recipe.name}: ${recipe.desc}`}
        onClick={
          enabled
            ? () => act('create', { path: recipe.path })
            : () => logger.warn(`Cannot buy ${recipe.name}`)
        }
        width="64px"
        height=""
        disabled={!enabled}
      >
        <DmIcon
          icon={recipe.icon_params?.icon}
          icon_state={recipe.icon_params?.state}
          frame={recipe.icon_params?.frame}
          direction={recipe.icon_params?.dir}
          movement={recipe.icon_params?.moving}
          height="64px"
          width="64px"
          top="0px"
          left="0px"
          position="absolute"
        />
        <Box
          position="absolute"
          top="0px"
          left="0px"
          backgroundColor="black"
          textColor="white"
          bold
          style={{ margin: '2px', borderRadius: '100%' }}
        >
          Cost: {recipe.cost}
        </Box>
      </Button>
    </Stack.Item>
  );
};

export const AntagInfoFlockAgent = () => {
  const { data } = useBackend<Info>();

  const [currentTab, setTab] = useState(1);
  const { lord_name, recipes, resources } = data;

  const tabs = [
    {
      label: 'Briefing',
      icon: 'info',
      content: <BriefingSection lordName={lord_name} />,
    },
    {
      label: 'Templates',
      icon: 'cubes',
      content: <RecipesSection resources={resources} recipes={recipes} />,
    },
  ];

  return (
    <Window width={750} height={635} theme={'theme-Flock'}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <Tabs fluid>
              {tabs.map((tab, index) => (
                <Tabs.Tab
                  key={index}
                  icon={tab.icon}
                  selected={currentTab === index}
                  onClick={() => setTab(index)}
                >
                  {tab.label}
                </Tabs.Tab>
              ))}
            </Tabs>
          </Stack.Item>
          <Stack.Item grow>{tabs[currentTab].content}</Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
